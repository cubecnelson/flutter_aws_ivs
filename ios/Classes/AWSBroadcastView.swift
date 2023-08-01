//
//  AWSBroadcastView.swift
//  StagesApp
//
//  Created by Nelson Cheung on 30/7/2023.
//

import Foundation
import UIKit
import AmazonIVSBroadcast


class AWSBroadcastView: UICollectionView {
    
    private let viewModel = StageViewModel()
    
    func initView() {
        
        self.dataSource = self
        self.delegate = self
        let podBundle = Bundle(for: self.classForCoder)
        self.register(UINib(nibName: "ParticipantCollectionViewCell", bundle: podBundle), forCellWithReuseIdentifier: "ParticipantCollectionViewCell")
        self.isScrollEnabled = false
        
        viewModel.participantUpdates.add { [weak self] (index, changeType, participant) in
            // UICollectionView automatically clears itself out when it gets detached from it's
            // superview it seems (which for us happens when the VC is dismissed).
            // So even though our update/insert/reload calls are in sync, the UICollectionView
            // thinks it has 0 items if this is invoked async after the VC is dismissed.
            guard self?.superview != nil else { return }
            switch changeType {
            case .inserted:
                self?.insertItems(at: [IndexPath(item: index, section: 0)])
            case .updated:
                // Instead of doing reloadItems, just grab the cell and update it ourselves. It saves a create/destroy of a cell
                // and more importantly fixes some UI glitches. We don't support scrolling at all so the index path per cell
                // never changes.
                guard let participant = participant else { return }
                if let cell = self?.cellForItem(at: IndexPath(item: index, section: 0)) as? ParticipantCollectionViewCell {
                    cell.set(participant: participant)
                }
            case .deleted:
                self?.deleteItems(at: [IndexPath(item: index, section: 0)])
            }
        }
        
        viewModel.errorAlerts.add { [weak self] error in
            // on error
        }
        
        viewModel.observableStageConnectionState.addAndNotify {_ in
        }
        
        viewModel.localUserAudioMuted.addAndNotify {_ in
        }
        
        viewModel.localUserVideoMuted.addAndNotify {_ in
        }
        
        
        viewModel.isBroadcasting.addAndNotify {_ in
        }
    }
    
    func toggleLocalVideoMute() -> Bool {
        viewModel.toggleLocalVideoMute()
        return viewModel.isVideoMuted;
    }
}


extension AWSBroadcastView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.participantCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParticipantCollectionViewCell", for: indexPath) as? ParticipantCollectionViewCell {
            let participant = viewModel.participantsData[indexPath.item]
            cell.set(participant: participant)
            cell.delegate = self
            return cell
        } else {
            fatalError("Couldn't load custom cell type 'ParticipantCollectionViewCell'")
        }
    }
}


extension AWSBroadcastView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ParticipantCollectionViewCell {
            cell.toggleEditMode()
        }
    }

}

extension AWSBroadcastView: ParticipantCollectionViewCellDelegate {
    
    func toggleAudioOnlySubscribe(forParticipant participantId: String) {
        viewModel.toggleAudioOnlySubscribe(forParticipant: participantId)
    }
    
}
